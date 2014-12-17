# -*- coding: utf-8 -*-

require "./abstractSofaHunter.rb"


class CSDNSofaHunter < SofaHunter

  def initialize()
    super("csdn")
    @agent = login()
  end

  def hunt_sofa()
    #进入bbs疯狂留言
    bbs_page = @agent.get("http://bbs.csdn.net/home")
    bbs_page.links.each do |link|
      if link.uri().to_s.include?("topics")
        begin
          topic_page = link.click()
          #已经留过言的就不在留了
          posted_topics = topic_page.form_with(:action => "/users/28655878/attention")
          if posted_topics.nil?
            #这里只能检查第一页，真正想不重复留言，需要检查每一页。
            puts link.uri()
          else
            puts "#{link.uri()} 已留言."
            next
          end
          post_f = topic_page.form_with(:method => "POST")
          post_field = post_f.field_with(:id => "post_body")
          post_field.value = randomWords
          post_f.submit
          sleep 10
        rescue Exception=>e
          p "-----------------------------------------------"
          p e
          p "-----------------------------------------------"
        end
      end
    end
  end

end
