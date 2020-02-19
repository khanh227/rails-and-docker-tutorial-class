module MenuHelper
  def menu_list
    Menu.pluck(:menu_name, :id)
  end

  def display_background_img(menu)
    menu.background_img.attached? ? url_for(menu.background_img) : ''
  end
end
