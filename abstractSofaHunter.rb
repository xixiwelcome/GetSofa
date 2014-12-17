# -*- coding: utf-8 -*-

require 'rubygems'
require 'mechanize'
require "./lib/SiteInfo.rb"

class SofaHunter

  def initialize(sitename)
    $SiteInfo = SiteInfo.new
    @site_info = $SiteInfo.get_site_info(sitename)
    @arr_words = []
    @words_cnt = 0
    obj_data = open("./words.txt", "r:GB2312")
    obj_data.each do |line|
      arr_div = line.gsub("\"", "").strip
      next if arr_div == ""
      @arr_words << arr_div
    end
    @words_cnt = @arr_words.length
  end

  def execute()
    begin
      hunt_sofa()
    rescue Exception => e
      p e
      @agent = login()
      retry
    end
  end

  #abstract
  #
  def hunt_sofa()
    
  end

  #登陆目标网站
  #
  def login()
    a = Mechanize.new
    page = a.get(@site_info[:login_url])
    form = page.form_with(:id => @site_info[:login_form_id])
    form.field_with(:name => @site_info[:username_field_name]).value = @site_info[:username]
    form.field_with(:name => @site_info[:password_field_name]).value = @site_info[:password]
    image_captcha = page.image_with(:id => @site_info[:captcha_image_field_id])
    if @site_info[:captcha_image_field_id] != "" && !image_captcha.nil?
      puts image_captcha.url
      puts "input the captcha in the link:"
      STDOUT.flush
      str_captcha = gets.chomp
      form.field_with(:name => @site_info[:captcha_field_name]).value = str_captcha
    end
    my_page = form.submit
    return a
  end


  def getNewTopics
    
  end

  def isSofaAvailable?
    
  end

  def reply
    
  end

  #随机生成一条留言
  #
  def randomWords
    return @arr_words[ rand(@words_cnt) ]
  end

end
