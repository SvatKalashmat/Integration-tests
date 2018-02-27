module PageObjects
  class MainPage < SitePrism::Page

    set_url '{locale}'

    section :header, HeaderSection, '.header.mod-sign.mod-dark'

  end
end
