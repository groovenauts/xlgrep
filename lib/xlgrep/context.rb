require 'xlgrep'

require 'roo'

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
        $stdout.puts("loading #{f}")
        book = book_for(f)
        book.sheets.each do |sheet|
          $stdout.puts("\rloading #{f} #{sheet}")
          book.default_sheet = sheet
          (book.first_row..book.last_row).each do |r|
            cells = book.row(r)
            cells.each.with_index do |cell, idx|
              @predicates.each do |pred|
                pred.match(cell) do |msg|
                  a, b = idx.divmod(26) # ('A'..'Z').length => 26
                  x = (a > 0 ? (BASE_CHAR_ORDER + a).chr : "") + (BASE_CHAR_ORDER + b).chr
                  @formatter.process({
                    file: f, sheet: sheet,
                    x: x, y: r,
                    data: cell,
                    msg: msg
                  })
                end
              end
            end
          end
        end
        $stdout.puts(" loaded #{f}")
      end
      self
    end

  end
end
