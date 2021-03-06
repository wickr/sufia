module Sufia
  module CitationsBehaviors
    module TitleBehavior
      include Sufia::CitationsBehaviors::CommonBehavior

      TITLE_NOCAPS = ["a", "an", "and", "but", "by", "for", "it", "of", "the", "to", "with"]
      EXPANDED_NOCAPS = TITLE_NOCAPS + ["about", "across", "before", "without"]

      def chicago_citation_title(title_text)
        process_title_parts(title_text) do |w, index|
          if (index == 0 && w != w.upcase) || (w.length > 1 && w != w.upcase && !EXPANDED_NOCAPS.include?(w))
            # the split("-") will handle the capitalization of hyphenated words
            w.split("-").map!(&:capitalize).join("-")
          else
            w
          end
        end
      end

      def mla_citation_title(title_text)
        process_title_parts(title_text) do |w|
          if TITLE_NOCAPS.include? w
            w
          else
            w.capitalize
          end
        end
      end

      def process_title_parts(title_text, &block)
        if block_given?
          title_text.split(" ").collect.with_index(&block).join(" ")
        else
          title_text
        end
      end

      def setup_title_info(work)
        text = ''
        title = work.title
        unless title.blank?
          title = CGI.escapeHTML(title)
          title_info = clean_end_punctuation(title.strip)
          text << title_info
        end

        return nil if text.strip.blank?
        clean_end_punctuation(text.strip) + "."
      end
    end
  end
end
