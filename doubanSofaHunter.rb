# -*- coding: utf-8 -*-

require "./abstractSofaHunter.rb"


class DoubanSofaHunter < SofaHunter

  def initialize()
    super("douban")
    @agent = login()
  end

  def hunt_sofa()
    group_page = @agent.get("http://www.douban.com/group/")
    group_page.links.each do |link|
      next if !link.uri().to_s.include?("/group/topic/")
      begin
        topic_page = link.click()
        next if topic_page.nil?
        post_f = topic_page.form_with(:method => "POST")
        next if post_f.nil?
        post_field = post_f.field_with(:name => "rv_comment")
        next if post_field.nil?
        post_field.value = randomWords

        #是否为沙发。
        comment_links = topic_page.link_with(:text => "赞", :href => "javascript:void(0);")
        next if !comment_links.nil?
        puts "###got sofa!(#{link.uri()})"
        post_f.submit
        sleep 10
      rescue Exception=>e
        puts e
      end
    end
    sleep 10
    puts "#######################refresh#######################"
    hunt_sofa()
  end

end
