class Channel < ApplicationRecord
  default_scope {where(is_active: true)}

  audited except: [:created_at, :updated_at]

  has_many :reports
  has_many :channel_permissions
  has_many :channel_orders
  belongs_to :user

  GROUPS = 1
  PUBLIC = 2
  PERSONAL = 3

  has_many :users, through: :channel_permissions
  scope :personal, -> { where(option: PERSONAL)}
  scope :for_current_user, -> { where(user_id: User.current.id) }
  scope :my_personal_channel, -> { personal.for_current_user }
  scope :not_personal, -> { where(option: [PUBLIC, GROUPS])}
  scope :is_public, -> { where(option: PUBLIC)}
  scope :for_shared_users, -> { where(option: GROUPS)}

  scope :for_user, -> { for_shared_users.
      includes(:channel_permissions).
      where(channel_permissions: {user_id: User.current.id, can_view: true}) + for_shared_users.for_current_user
  }
  scope :visible, -> { is_public + for_user + my_personal_channel }

  # accepts_nested_attributes_for :channel_users, reject_if: :all_blank, allow_destroy: true


  belongs_to :created_by, class_name: 'User', optional: true
  belongs_to :updated_by, class_name: 'User', optional: true

  validates_presence_of :name
  validates_uniqueness_of :name, scope: [:user_id]

  def is_creator?
    user_id == User.current.id
  end

  def active_users
    case option
      when PUBLIC then User.all
      when GROUPS then User.where(id: channel_permissions.where(can_view: true).pluck(:user_id) )
      when PERSONAL then [user]
      else
        []
    end
  end

  def my_permission
    @permission ||= channel_permissions.where(user_id: User.current.id).first_or_initialize
  end

  before_create do
    self.created_by_id = User.current.id
  end

  before_save do
    self.updated_by_id = User.current.id
  end

  after_create do
    ChannelUser.create(user_id: self.user_id, channel_id: self.id)

    # TODO after create send notification
  end

  after_update do
    active_users.each do |user|
      NotificationMailer.channel_updated(user, self).deliver_later
    end
  end

  def self.market_place
    personal.where(user_id: User.current.id, name: 'Market Analyses' ).first_or_create
  end

   def self.shared_report
    personal.where(user_id: User.current.id, name: 'Shared Report', option: PERSONAL ).first_or_create
   end

  def shared_report?
    name == 'Shared Report'
  end

  def self.segmented_market
    personal.where(user_id: User.current.id, name: 'Segmented Market' ).first_or_create
  end

  ICONS = ["fa-glass", "fa-music", "fa-search", "fa-envelope", "fa-heart", "fa-star", "fa-user", "fa-film", "fa-th", "fa-check", "fa-remove", "fa-close", "fa-times",
      "fa-power", "fa-signal", "fa-gear", "fa-cog", "fa-trash", "fa-home", "fa-file", "fa-clock", "fa-road", "fa-download", "fa-arrow", "fa-inbox", "fa-play",
      "fa-rotate", "fa-repeat", "fa-refresh", "fa-list", "fa-lock", "fa-flag", "fa-headphones", "fa-volume", "fa-qrcode", "fa-barcode", "fa-tag", "fa-tags", "fa-book", "fa-bookmark", "fa-print", "fa-camera", "fa-font",
      "fa-bold", "fa-italic", "fa-text", "fa-align", "fa-dedent", "fa-outdent", "fa-indent", "fa-video", "fa-photo", "fa-image", "fa-picture", "fa-pencil", "fa-map", "fa-adjust", "fa-tint", "fa-edit", "fa-share",
      "fa-arrows", "fa-step", "fa-fast", "fa-backward", "fa-pause", "fa-stop", "fa-forward", "fa-eject", "fa-chevron", "fa-plus", "fa-minus", "fa-question", "fa-info", "fa-crosshairs", "fa-ban", "fa-mail", "fa-expand",
      "fa-compress", "fa-asterisk", "fa-exclamation", "fa-gift", "fa-leaf", "fa-fire", "fa-eye", "fa-warning", "fa-plane", "fa-calendar", "fa-random", "fa-comment", "fa-magnet", "fa-retweet", "fa-shopping", "fa-folder",
      "fa-bar", "fa-twitter", "fa-facebook", "fa-key", "fa-gears", "fa-cogs", "fa-comments", "fa-thumbs", "fa-sign", "fa-linkedin", "fa-thumb", "fa-external", "fa-trophy", "fa-github", "fa-upload",
      "fa-lemon", "fa-phone", "fa-square", "fa-unlock", "fa-credit", "fa-feed", "fa-rss", "fa-hdd", "fa-bullhorn", "fa-bell", "fa-certificate", "fa-hand", "fa-globe", "fa-wrench", "fa-tasks", "fa-filter",
      "fa-briefcase", "fa-group", "fa-users", "fa-chain", "fa-link", "fa-cloud", "fa-flask", "fa-cut", "fa-scissors", "fa-copy", "fa-files", "fa-paperclip", "fa-save", "fa-floppy", "fa-navicon", "fa-reorder", "fa-bars", "fa-strikethrough", "fa-underline",
      "fa-table", "fa-magic", "fa-truck", "fa-pinterest", "fa-google", "fa-money", "fa-caret", "fa-columns", "fa-unsorted", "fa-sort", "fa-undo", "fa-legal", "fa-gavel", "fa-dashboard", "fa-tachometer", "fa-flash", "fa-bolt", "fa-sitemap", "fa-umbrella",
      "fa-paste", "fa-clipboard", "fa-lightbulb", "fa-exchange", "fa-stethoscope", "fa-suitcase", "fa-coffee", "fa-cutlery", "fa-building", "fa-hospital", "fa-ambulance", "fa-medkit", "fa-fighter", "fa-beer", "fa-h",
      "fa-angle", "fa-desktop", "fa-laptop", "fa-tablet", "fa-mobile", "fa-circle", "fa-quote", "fa-spinner", "fa-reply", "fa-smile", "fa-frown", "fa-meh", "fa-gamepad", "fa-keyboard", "fa-terminal", "fa-code",
      "fa-location", "fa-crop", "fa-unlink", "fa-superscript", "fa-subscript", "fa-eraser", "fa-puzzle", "fa-microphone", "fa-shield", "fa-rocket", "fa-maxcdn", "fa-html5", "fa-css3", "fa-anchor", "fa-bullseye", "fa-ellipsis", "fa-ticket", "fa-level", "fa-compass",
      "fa-toggle", "fa-euro", "fa-eur", "fa-gbp", "fa-dollar", "fa-usd", "fa-rupee", "fa-inr", "fa-cny", "fa-rmb", "fa-yen", "fa-jpy", "fa-ruble", "fa-rouble", "fa-rub", "fa-won", "fa-krw", "fa-bitcoin",
      "fa-btc", "fa-youtube", "fa-xing", "fa-dropbox", "fa-stack", "fa-instagram", "fa-flickr", "fa-adn", "fa-bitbucket", "fa-tumblr", "fa-long", "fa-apple", "fa-windows", "fa-android", "fa-linux", "fa-dribbble", "fa-skype", "fa-foursquare", "fa-trello",
      "fa-female", "fa-male", "fa-gittip", "fa-gratipay", "fa-sun", "fa-moon", "fa-archive", "fa-bug", "fa-vk", "fa-weibo", "fa-renren", "fa-pagelines", "fa-dot", "fa-wheelchair", "fa-vimeo", "fa-turkish",
      "fa-try", "fa-space", "fa-slack", "fa-wordpress", "fa-openid", "fa-institution", "fa-bank", "fa-university", "fa-mortar", "fa-graduation", "fa-yahoo", "fa-reddit", "fa-stumbleupon",
      "fa-delicious", "fa-digg", "fa-pied", "fa-drupal", "fa-joomla", "fa-language", "fa-fax", "fa-child", "fa-paw", "fa-spoon", "fa-cube", "fa-cubes",
      "fa-behance", "fa-steam", "fa-recycle", "fa-automobile", "fa-car", "fa-cab", "fa-taxi", "fa-tree", "fa-spotify", "fa-deviantart", "fa-soundcloud", "fa-database", "fa-vine",
      "fa-codepen", "fa-jsfiddle", "fa-life", "fa-support", "fa-ra", "fa-resistance", "fa-rebel", "fa-ge", "fa-empire", "fa-git", "fa-y", "fa-yc", "fa-hacker", "fa-tencent",
      "fa-qq", "fa-wechat", "fa-weixin", "fa-send", "fa-paper", "fa-history", "fa-header", "fa-paragraph", "fa-sliders", "fa-bomb", "fa-soccer", "fa-futbol", "fa-tty", "fa-binoculars", "fa-plug", "fa-slideshare",
      "fa-twitch", "fa-yelp", "fa-newspaper", "fa-wifi", "fa-calculator", "fa-paypal", "fa-cc", "fa-copyright", "fa-at", "fa-eyedropper", "fa-paint", "fa-birthday", "fa-area", "fa-pie", "fa-line", "fa-lastfm",
      "fa-bicycle", "fa-bus", "fa-ioxhost", "fa-angellist", "fa-shekel", "fa-sheqel", "fa-ils", "fa-meanpath", "fa-buysellads", "fa-connectdevelop", "fa-dashcube", "fa-forumbee", "fa-leanpub", "fa-sellsy", "fa-shirtsinbulk", "fa-simplybuilt",
      "fa-skyatlas", "fa-cart", "fa-diamond", "fa-ship", "fa-motorcycle", "fa-street", "fa-heartbeat", "fa-venus", "fa-mars", "fa-mercury", "fa-intersex", "fa-transgender", "fa-neuter", "fa-genderless", "fa-whatsapp", "fa-server",
      "fa-hotel",     "fa-bed", "fa-viacoin", "fa-train", "fa-subway", "fa-medium", "fa-optin", "fa-opencart", "fa-expeditedssl", "fa-battery", "fa-mouse", "fa-i", "fa-object", "fa-sticky", "fa-clone",
      "fa-balance", "fa-hourglass", "fa-trademark", "fa-registered", "fa-creative", "fa-gg", "fa-tripadvisor", "fa-odnoklassniki", "fa-get", "fa-wikipedia",
      "fa-safari", "fa-chrome", "fa-firefox", "fa-opera", "fa-internet", "fa-tv", "fa-television", "fa-contao", "fa-500px", "fa-amazon", "fa-industry", "fa-commenting", "fa-houzz", "fa-black", "fa-fonticons",
      "fa-edge", "fa-codiepie", "fa-modx", "fa-fort", "fa-usb", "fa-product", "fa-mixcloud", "fa-scribd", "fa-hashtag", "fa-bluetooth", "fa-percent", "fa-gitlab", "fa-wpbeginner", "fa-wpforms", "fa-envira", "fa-universal", "fa-blind",
      "fa-audio", "fa-braille", "fa-assistive", "fa-asl", "fa-american", "fa-deafness", "fa-hard", "fa-deaf", "fa-glide", "fa-signing", "fa-low", "fa-viadeo", "fa-snapchat", "fa-first", "fa-yoast",
      "fa-themeisle", "fa-fa", "fa-handshake", "fa-linode", "fa-address", "fa-vcard", "fa-id", "fa-drivers", "fa-quora", "fa-free", "fa-telegram", "fa-thermometer", "fa-shower",
      "fa-bathtub", "fa-s15", "fa-bath", "fa-podcast", "fa-window", "fa-bandcamp", "fa-grav", "fa-etsy", "fa-imdb", "fa-ravelry", "fa-eercast",
      "fa-microchip", "fa-snowflake", "fa-superpowers", "fa-wpexplorer", "fa-meetup"]


  def self.safe_attributes
    [:user_id, :name, :is_public, :description, :is_personal, :icon, :option]
  end

  def visible_reports
    if is_personal?
      User.current.reports.where(channel_id: self.id)
    elsif is_public?
      reports
    else
      reports
    end
  end

  def is_personal?
    option == PERSONAL
  end

  def is_public?
    option == PUBLIC
  end

  def to_s
    name
  end
end
