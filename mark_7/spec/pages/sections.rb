
class Toast < SitePrism::Section
    element :message, '.toast-message'
    element :close, '.toast-close-button'
end

class TopMenu < SitePrism::Section
    element :usermenu, '.profil-link a[href*=dropdown]'
    element :logout, 'a[href$=logout]'
  
    def faz_logout
      self.usermenu.click
      self.logout.click
    end
end
