require 'lotus/helpers/html_helper/empty_html_node'

module Lotus
  module Helpers
    module HtmlHelper
      class HtmlNode < EmptyHtmlNode
        def initialize(builder, name, content, attributes)
          @builder    = builder
          @name       = name
          @content    = case content
                        when Hash
                          @attributes = content
                          nil
                        else
                          @attributes = attributes.to_h if attributes.respond_to?(:to_h)
                          content
                        end
        end

        def content
          case @content
          when Proc
            "\n#{ @builder.instance_exec(&@content) }\n"
          else
            @content
          end
        end

        def to_s
          %(#{ super }#{ content }</#{ @name }>)
        end
      end
    end
  end
end
