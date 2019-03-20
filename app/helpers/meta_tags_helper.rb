module MetaTagsHelper
  KEY_WORDS_BRAND = %W[
    apple
    samsung
    htc
    lg
    sony
    ausus
    oppo
    nokia
    panasonic
    motorola
    小米
  ].freeze

  KEY_WORDS_TELE = %W[
    中華電信
    emome
    HiNet
    遠傳電信
    FETnet
    台灣大哥大
    Taiwanmobile
    TWM
    台灣之星
    tstart
    TSTART
    Tstart
    T-start
    亞太電信
  ].freeze

  def meta_tags_params
    if @page_keywords.nil?
      default_keywords = "js,jspe,就是便宜,手機,手機便宜,手機就是便宜,iphone,iPhone"

      KEY_WORDS_TELE.each do |keyword|
        default_keywords += "," + keyword
      end

      KEY_WORDS_BRAND.each do |keyword|
        default_keywords += "," + keyword
      end
    end

    {
      site: "jspe 就是便宜",
      title: @page_title || "jspe 手機 低價 就是便宜",
      reverse: true,
      description: @page_description || "jspe 手機 低價 就是便宜",
      keywords: @page_keywords || default_keywords,
      canonical: request.original_url,
      charset: "UTF-8",
      og: {
        site_name: "jspe 就是便宜",
        title: @page_title || "jspe 手機 低價 就是便宜",
        description: @page_description || "jspe 找手機 就是便宜",
        type: "website",
        url: request.original_url,
        image: image_url("logo.jpg"),
        locale: "zh_tw"
      },
      twitter: {
        site: "jspe 就是便宜",
        card: "summary",
        image: image_url("logo.jpg")
	    }
    }
  end
end
