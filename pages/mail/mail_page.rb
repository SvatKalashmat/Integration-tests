module PageObjects
  class MailPage < SitePrism::Page

    section :notification, NotificationSection, '.sign-msg-content'

    def base64
      'Content-Transfer-Encoding: base64'
    end

    def to_text(html)
      ActionController::Base.helpers.strip_tags(html).gsub(/\s+/,' ')
    end

    def mailbox
      mailbox = MailCatcher::API::Mailbox.new
    end

    def go_to_link(url)
      Capybara.visit url
    end

    def clear_mails
      uri = URI.parse("http://localhost:1080/messages")
      request = Net::HTTP::Delete.new(uri)

      req_options = {
        use_ssl: uri.scheme == "https",
      }

      response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
      end
    end

    def encoding_mail_body_ru
      Base64.decode64(mailbox.messages.last.body).force_encoding("UTF-8")
    end

    def add_port(url)
      link = url[0..21] + ":" + Capybara.current_session.server.port.to_s + url[22..-1]
    end

    def get_link_and_click
      if mailbox.messages.last.raw.include?(base64)
        link = encoding_mail_body_ru.match(/href\=\"(.+)\"/)[1]
        go_to_link(add_port(link))
      else
        link = mailbox.messages.last.links.join(",")
        go_to_link(add_port(link))
      end
    end

    def mail_text
      if mailbox.messages.last.raw.include?(base64)
        to_text(encoding_mail_body_ru)
      else
        to_text(mailbox.messages.last.body)
      end
    end

  end
end
