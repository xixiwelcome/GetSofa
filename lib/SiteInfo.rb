# -*- coding: utf-8 -*-

class SiteInfo

HAS_SITE_INFO_DOUBAN = {
  :login_url => "http://www.douban.com/accounts/login?source=group",
  :username => "",
  :password => "",
  :login_form_id => "lzform",
  :username_field_name => "form_email",
  :password_field_name => "form_password",
  :captcha_image_field_id => "captcha_image",
  :captcha_field_name => "captcha-solution"

}

HAS_SITE_INFO_CSDN = {
  :login_url => "https://passport.csdn.net/account/login?from=http://my.csdn.net/my/mycsdn",
  :username => "",
  :password => "",
  :login_form_id => "fm1",
  :username_field_name => "username",
  :password_field_name => "password",
  :captcha_image_field_id => "",
  :captcha_field_name => ""
}

def get_site_info(sitename)
  return eval("HAS_SITE_INFO_#{sitename.upcase}")
end

end
