module Syobocalite
  class Program
    # @!attribute pid
    #   @return [Integer]
    attr_accessor :pid

    # @!attribute tid
    #   @return [Integer]
    attr_accessor :tid

    # @!attribute st_time
    #   @return [ActiveSupport::TimeWithZone]
    attr_accessor :st_time

    # @!attribute ed_time
    #   @return [ActiveSupport::TimeWithZone]
    attr_accessor :ed_time

    # @!attribute ch_name
    #   @return [String]
    attr_accessor :ch_name

    # @!attribute ch_id
    #   @return [Integer]
    attr_accessor :ch_id

    # @!attribute count
    #   @return [Integer]
    attr_accessor :count

    # @!attribute st_offset
    #   @return [Integer]
    attr_accessor :st_offset

    # @!attribute sub_title
    #   @return [String]
    attr_accessor :sub_title

    # @!attribute title
    #   @return [String]
    attr_accessor :title

    # @!attribute prog_comment
    #   @return [String]
    attr_accessor :prog_comment

    # @param pid          [Integer]
    # @param tid          [Integer]
    # @param st_time      [ActiveSupport::TimeWithZone]
    # @param ed_time      [ActiveSupport::TimeWithZone]
    # @param ch_name      [String]
    # @param ch_id        [Integer]
    # @param count        [Integer]
    # @param st_offset    [Integer]
    # @param sub_title    [String]
    # @param title        [String]
    # @param prog_comment [String]
    def initialize(pid: nil, tid: nil, st_time: nil, ed_time: nil, ch_name: nil, ch_id: nil,
                   count: nil, st_offset: nil, sub_title: nil, title: nil, prog_comment: nil)
      @pid          = pid
      @tid          = tid
      @st_time      = st_time
      @ed_time      = ed_time
      @ch_name      = ch_name
      @ch_id        = ch_id
      @count        = count
      @st_offset    = st_offset
      @sub_title    = sub_title
      @title        = title
      @prog_comment = prog_comment
    end

    alias_method :story_number,  :count
    alias_method :story_number=, :count=

    # @param attrs [Hash]
    #
    # @return [Syobocalite::Program]
    def self.from_prog_item(attrs = {})
      Syobocalite::Program.new(
        pid:          attrs["PID"]&.to_i,
        tid:          attrs["TID"]&.to_i,
        st_time:      to_time(attrs["StTime"]),
        ed_time:      to_time(attrs["EdTime"]),
        ch_name:      attrs["ChName"],
        ch_id:        attrs["ChID"]&.to_i,
        count:        attrs["Count"]&.to_i,
        st_offset:    attrs["StOffset"]&.to_i,
        sub_title:    sanitize_text(attrs["SubTitle"]),
        title:        sanitize_text(attrs["Title"]),
        prog_comment: attrs["ProgComment"]&.gsub(/^!/, ""),
      )
    end

    def self.to_time(str)
      return nil unless str

      Time.use_zone("Tokyo") do
        Time.zone.parse(str)
      end
    end
    private_class_method :to_time

    def self.sanitize_text(str)
      return nil unless str

      CGI.unescapeHTML(str)
    end
    private_class_method :sanitize_text
  end
end
