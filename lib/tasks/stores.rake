namespace :stores do
  desc "create_init_store"
  task create_init_store: :environment do
    puts "開始建立初始門市"

    attributes = {
      name: "初始門市",
      service_line: "line",
      address: "台灣",
      time: "24h",
      google_map_url: "https://www.google.com"
    }
    store = Store.new(attributes)

    if store.save
      puts "創造初始門市成功, 請註冊一個會員後進 console 把該使用者 add_rule :admin 後即可開始從首頁維護後台"
    else
      puts "創造初始門市失敗, 請查看程式碼或手動進 console 建立"
    end
  end
end
