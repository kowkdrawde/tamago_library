class Book < ActiveRecord::Base
  require "common_method.rb"  
  include CommonMethod

  attr_accessor :wantreason

  before_create :gen_id, :gen_image_id
  before_update :gen_image_id
  after_create :add_matched_list, :update_book_stat
  after_update :update_book_stat
  after_destroy :update_book_stat
  belongs_to :user
  has_many :wanteds, dependent: :destroy
  has_attached_file :image, styles: {thumbnail: "400x"}
  has_one :matched, dependent: :destroy
  has_and_belongs_to_many :booktags

  validates_attachment :image, content_type: {content_type: ["image/jpeg", "image/png", "image/gif"]}

  
  default_scope {order(availability: :desc, updated_at: :desc)}

  def self.search_books(params)
  	if params[:search] && params[:search]!=""
  	  includes(:booktags).where(
        ['title ILIKE ? OR author ILIKE ? OR loc ILIKE ? OR country ILIKE ? OR isbn ILIKE ? OR user_id = ? OR booktags.name ILIKE ?', 
        "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", 
        "%#{params[:search]}%", params[:search].to_i, "#{params[:search]}"]).references(:booktags)
    else all 
    end
  end

  # This method will extract the words and find or create a Tag
  def str_tags=(input_tags)
    self.booktags = input_tags.split(/\W+/).map do |tag|
      Booktag.find_or_create_by(name: tag.downcase)
    end
  end

  # This method will show the existing tags in our form
  def str_tags
    booktags.pluck(:name).join(',')
  end

  private

  def gen_id
    self.id = randomise_id(self.class)
  end

  def gen_image_id
    if self.image_file_name_changed?
      rand_file_name = SecureRandom.hex(16).to_s        
      gen_image_id if !Book.find_by(image_file_name: rand_file_name).nil? #re-generate image_id if exists
      # to cater for update of images by deleting original one.  Avoid new image_file_name_was coincides with existing resources
      bk = Book.find_by(image_file_name: self.image_file_name_was)
      bk.image.destroy if !bk.nil?
      self.image.instance_write(:file_name, rand_file_name)
    end
  end

  def add_matched_list
    Matched.create(book_id: self.id)
  end

  def update_book_stat

    freq_loc = Book.unscoped.group(:loc).order('count_loc DESC').count(:loc).first(3)
    Stat.find_by(name: "freq_loc").update(content: freq_loc.to_h)
    
    avail_book_count = {"avail_book_count" => Book.where(availability: true).count}
    Stat.find_by(name: "avail_book_count").update(content: avail_book_count)
  end

  def self.countries
    ["Afghanistan",
    "Aland Islands",
    "Albania",
    "Algeria",
    "American Samoa",
    "Andorra",
    "Angola",
    "Anguilla",
    "Antarctica",
    "Antigua And Barbuda",
    "Argentina",
    "Armenia",
    "Aruba",
    "Australia",
    "Austria",
    "Azerbaijan",
    "Bahamas",
    "Bahrain",
    "Bangladesh",
    "Barbados",
    "Belarus",
    "Belgium",
    "Belize",
    "Benin",
    "Bermuda",
    "Bhutan",
    "Bolivia",
    "Bosnia and Herzegowina",
    "Botswana",
    "Bouvet Island",
    "Brazil",
    "British Indian Ocean Territory",
    "Brunei Darussalam",
    "Bulgaria",
    "Burkina Faso",
    "Burundi",
    "Cambodia",
    "Cameroon",
    "Canada",
    "Cape Verde",
    "Cayman Islands",
    "Central African Republic",
    "Chad",
    "Chile",
    "China",
    "Christmas Island",
    "Cocos (Keeling) Islands",
    "Colombia",
    "Comoros",
    "Congo",
    "Congo, the Democratic Republic of the",
    "Cook Islands",
    "Costa Rica",
    "Cote d'Ivoire",
    "Croatia",
    "Cuba",
    "Cyprus",
    "Czech Republic",
    "Denmark",
    "Djibouti",
    "Dominica",
    "Dominican Republic",
    "Ecuador",
    "Egypt",
    "El Salvador",
    "Equatorial Guinea",
    "Eritrea",
    "Estonia",
    "Ethiopia",
    "Falkland Islands (Malvinas)",
    "Faroe Islands",
    "Fiji",
    "Finland",
    "France",
    "French Guiana",
    "French Polynesia",
    "French Southern Territories",
    "Gabon",
    "Gambia",
    "Georgia",
    "Germany",
    "Ghana",
    "Gibraltar",
    "Greece",
    "Greenland",
    "Grenada",
    "Guadeloupe",
    "Guam",
    "Guatemala",
    "Guernsey",
    "Guinea",
    "Guinea-Bissau",
    "Guyana",
    "Haiti",
    "Heard and McDonald Islands",
    "Holy See (Vatican City State)",
    "Honduras",
    "Hong Kong",
    "Hungary",
    "Iceland",
    "India",
    "Indonesia",
    "Iran, Islamic Republic of",
    "Iraq",
    "Ireland",
    "Isle of Man",
    "Israel",
    "Italy",
    "Jamaica",
    "Japan",
    "Jersey",
    "Jordan",
    "Kazakhstan",
    "Kenya",
    "Kiribati",
    "Korea, Democratic People's Republic of",
    "Korea, Republic of",
    "Kuwait",
    "Kyrgyzstan",
    "Lao People's Democratic Republic",
    "Latvia",
    "Lebanon",
    "Lesotho",
    "Liberia",
    "Libyan Arab Jamahiriya",
    "Liechtenstein",
    "Lithuania",
    "Luxembourg",
    "Macao",
    "Macedonia, The Former Yugoslav Republic Of",
    "Madagascar",
    "Malawi",
    "Malaysia",
    "Maldives",
    "Mali",
    "Malta",
    "Marshall Islands",
    "Martinique",
    "Mauritania",
    "Mauritius",
    "Mayotte",
    "Mexico",
    "Micronesia, Federated States of",
    "Moldova, Republic of",
    "Monaco",
    "Mongolia",
    "Montenegro",
    "Montserrat",
    "Morocco",
    "Mozambique",
    "Myanmar",
    "Namibia",
    "Nauru",
    "Nepal",
    "Netherlands",
    "Netherlands Antilles",
    "New Caledonia",
    "New Zealand",
    "Nicaragua",
    "Niger",
    "Nigeria",
    "Niue",
    "Norfolk Island",
    "Northern Mariana Islands",
    "Norway",
    "Oman",
    "Pakistan",
    "Palau",
    "Palestinian Territory, Occupied",
    "Panama",
    "Papua New Guinea",
    "Paraguay",
    "Peru",
    "Philippines",
    "Pitcairn",
    "Poland",
    "Portugal",
    "Puerto Rico",
    "Qatar",
    "Reunion",
    "Romania",
    "Russian Federation",
    "Rwanda",
    "Saint Barthelemy",
    "Saint Helena",
    "Saint Kitts and Nevis",
    "Saint Lucia",
    "Saint Pierre and Miquelon",
    "Saint Vincent and the Grenadines",
    "Samoa",
    "San Marino",
    "Sao Tome and Principe",
    "Saudi Arabia",
    "Senegal",
    "Serbia",
    "Seychelles",
    "Sierra Leone",
    "Singapore",
    "Slovakia",
    "Slovenia",
    "Solomon Islands",
    "Somalia",
    "South Africa",
    "South Georgia and the South Sandwich Islands",
    "Spain",
    "Sri Lanka",
    "Sudan",
    "Suriname",
    "Svalbard and Jan Mayen",
    "Swaziland",
    "Sweden",
    "Switzerland",
    "Syrian Arab Republic",
    "Taiwan",
    "Tajikistan",
    "Tanzania, United Republic of",
    "Thailand",
    "Timor-Leste",
    "Togo",
    "Tokelau",
    "Tonga",
    "Trinidad and Tobago",
    "Tunisia",
    "Turkey",
    "Turkmenistan",
    "Turks and Caicos Islands",
    "Tuvalu",
    "Uganda",
    "Ukraine",
    "United Arab Emirates",
    "United Kingdom",
    "United States",
    "United States Minor Outlying Islands",
    "Uruguay",
    "Uzbekistan",
    "Vanuatu",
    "Venezuela",
    "Viet Nam",
    "Virgin Islands, British",
    "Virgin Islands, U.S.",
    "Wallis and Futuna",
    "Western Sahara",
    "Yemen",
    "Zambia",
    "Zimbabwe"] 
  end

end
