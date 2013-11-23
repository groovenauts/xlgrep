require 'xlgrep'

require 'roo'
require 'highline'

module Xlgrep
  class Context
    def initialize(predicates, formatter = nil)
      @predicates = predicates
      @formatter = formatter || SimpleFormatter.new
    end

    def book_for(file)
      Roo::Spreadsheet.open(file)
    end

    BASE_CHAR_ORDER = 'A'.ord

    def execute(files)
      files.each do |f|
        book = book_for(f)
        book.sheets.each do |sheet|
          print_status("loading #{f} #{sheet}")

          book.default_sheet = sheet
          (book.first_row..book.last_row).each do |r|
            cells = book.row(r)
            cells.each.with_index do |cell, idx|
              @predicates.each do |pred|
                pred.match(cell) do |msg|
                  a, b = idx.divmod(26) # ('A'..'Z').length => 26
                  x = (a > 0 ? (BASE_CHAR_ORDER + a).chr : "") + (BASE_CHAR_ORDER + b).chr
                  print_status("")
                  @formatter.process({
                    file: f, sheet: sheet,
                    x: x, y: r,
                    data: cell,
                    msg: msg
                  })
                  print_status("loading #{f} #{sheet}")
                end
              end
            end
          end
        end
        # print_status(" loaded #{f}")
        # puts
      end
      print_status("")
      self
    end

    def print_status(s)
      return unless $stdout.tty?
      cols, rows = HighLine::SystemExtensions.terminal_size # [columns, lines]
      slen = cols - s.bytesize
      slen = 0 if slen < 0
      $stdout.print("\r" + s + (" " * slen))
    end

  end
end
