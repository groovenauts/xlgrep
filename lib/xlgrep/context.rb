require 'roo'

module Xlgrep
  class Context
    def initialize(predicates)
      @predicates = predicates
    end

    def book_for(file)
      klass, options =
        case ext = File.extname(file)
        when ".ods"  then Roo::OpenOffice
        when ".xls"  then Roo::Excel
        when ".xlsx" then Roo::Excelx
        when ".csv"  then Roo::CSV
        when ".tsv"  then [Roo::CSV, {csv_options: {col_sep: "\t"}}]
        else raise ArgumentError, "Unsupported file extension: #{ext.inspect}"
        end
      klass.new(file, options)
    end

    BASE_CHAR_ORDER = 'A'.ord

    def execute(files)
      result = []
      files.each do |f|
        book = book_for(f)
        book.sheets.each do |sheet|
          book.default_sheet = sheet
          (book.first_row..book.last_row).each do |r|
            cells = book.row(r)
            cells.each.with_index do |cell, idx|
              @predicates.each do |pred|
                pred.match(cell) do |msg|
                  a, b = idx.divmod(26) # ('A'..'Z').length => 26
                  x = (a > 0 ? (BASE_CHAR_ORDER + a).chr : "") + (BASE_CHAR_ORDER + b).chr
                  result << {
                    file: f, sheet: sheet,
                    x: x, y: r,
                    data: cell,
                    msg: msg
                  }
                end
              end
            end
          end
        end
      end
      result
    end

  end
end
