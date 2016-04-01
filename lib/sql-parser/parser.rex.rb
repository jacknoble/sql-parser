#--
# DO NOT MODIFY!!!!
# This file is automatically generated by rex 1.0.5
# from lexical definition file "lib/sql-parser/parser.rex".
#++

require 'racc/parser'
class SQLParser::Parser < Racc::Parser
  require 'strscan'

  class ScanError < StandardError ; end

  attr_reader   :lineno
  attr_reader   :filename
  attr_accessor :state

  def scan_setup(str)
    @ss = StringScanner.new(str)
    @lineno =  1
    @state  = nil
  end

  def action
    yield
  end

  def scan_str(str)
    scan_setup(str)
    do_parse
  end
  alias :scan :scan_str

  def load_file( filename )
    @filename = filename
    open(filename, "r") do |f|
      scan_setup(f.read)
    end
  end

  def scan_file( filename )
    load_file(filename)
    do_parse
  end


  def next_token
    return if @ss.eos?
    
    # skips empty actions
    until token = _next_token or @ss.eos?; end
    token
  end

  def _next_token
    text = @ss.peek(1)
    @lineno  +=  1  if text == "\n"
    token = case @state
    when nil
      case
      when (text = @ss.scan(/\"[0-9]+-[0-9]+-[0-9]+\"/i))
         action { [:date_string, Date.parse(text)] }

      when (text = @ss.scan(/\'[0-9]+-[0-9]+-[0-9]+\'/i))
         action { [:date_string, Date.parse(text)] }

      when (text = @ss.scan(/\'/i))
         action { @state = :STRS;  [:quote, text] }

      when (text = @ss.scan(/\"/i))
         action { @state = :STRD;  [:quote, text] }

      when (text = @ss.scan(/[0-9]+/i))
         action { [:unsigned_integer, text.to_i] }

      when (text = @ss.scan(/\s+/i))
        ;

      when (text = @ss.scan(/\-\-.*$/i))
        ;

      when (text = @ss.scan(/SELECT/i))
         action { [:SELECT, text] }

      when (text = @ss.scan(/DATE/i))
         action { [:DATE, text] }

      when (text = @ss.scan(/ASC/i))
         action { [:ASC, text] }

      when (text = @ss.scan(/AS/i))
         action { [:AS, text] }

      when (text = @ss.scan(/FROM/i))
         action { [:FROM, text] }

      when (text = @ss.scan(/WHERE/i))
         action { [:WHERE, text] }

      when (text = @ss.scan(/BETWEEN/i))
         action { [:BETWEEN, text] }

      when (text = @ss.scan(/AND/i))
         action { [:AND, text] }

      when (text = @ss.scan(/NOT/i))
         action { [:NOT, text] }

      when (text = @ss.scan(/INNER/i))
         action { [:INNER, text] }

      when (text = @ss.scan(/INSERT/i))
         action { [:INSERT, text] }

      when (text = @ss.scan(/INTO/i))
         action { [:INTO, text] }

      when (text = @ss.scan(/IN/i))
         action { [:IN, text] }

      when (text = @ss.scan(/ORDER/i))
         action { [:ORDER, text] }

      when (text = @ss.scan(/OR/i))
         action { [:OR, text] }

      when (text = @ss.scan(/LIKE/i))
         action { [:LIKE, text] }

      when (text = @ss.scan(/IS/i))
         action { [:IS, text] }

      when (text = @ss.scan(/NULL/i))
         action { [:NULL, text] }

      when (text = @ss.scan(/COUNT/i))
         action { [:COUNT, text] }

      when (text = @ss.scan(/AVG/i))
         action { [:AVG, text] }

      when (text = @ss.scan(/MAX/i))
         action { [:MAX, text] }

      when (text = @ss.scan(/MIN/i))
         action { [:MIN, text] }

      when (text = @ss.scan(/SUM/i))
         action { [:SUM, text] }

      when (text = @ss.scan(/GROUP/i))
         action { [:GROUP, text] }

      when (text = @ss.scan(/BY/i))
         action { [:BY, text] }

      when (text = @ss.scan(/HAVING/i))
         action { [:HAVING, text] }

      when (text = @ss.scan(/CROSS/i))
         action { [:CROSS, text] }

      when (text = @ss.scan(/JOIN/i))
         action { [:JOIN, text] }

      when (text = @ss.scan(/ON/i))
         action { [:ON, text] }

      when (text = @ss.scan(/LEFT/i))
         action { [:LEFT, text] }

      when (text = @ss.scan(/OUTER/i))
         action { [:OUTER, text] }

      when (text = @ss.scan(/RIGHT/i))
         action { [:RIGHT, text] }

      when (text = @ss.scan(/FULL/i))
         action { [:FULL, text] }

      when (text = @ss.scan(/USING/i))
         action { [:USING, text] }

      when (text = @ss.scan(/EXISTS/i))
         action { [:EXISTS, text] }

      when (text = @ss.scan(/DESC/i))
         action { [:DESC, text] }

      when (text = @ss.scan(/CURRENT_USER/i))
         action { [:CURRENT_USER, text] }

      when (text = @ss.scan(/VALUES/i))
         action { [:VALUES, text] }

      when (text = @ss.scan(/E/i))
         action { [:E, text] }

      when (text = @ss.scan(/<>/i))
         action { [:not_equals_operator, text] }

      when (text = @ss.scan(/!=/i))
         action { [:not_equals_operator, text] }

      when (text = @ss.scan(/=/i))
         action { [:equals_operator, text] }

      when (text = @ss.scan(/<=/i))
         action { [:less_than_or_equals_operator, text] }

      when (text = @ss.scan(/</i))
         action { [:less_than_operator, text] }

      when (text = @ss.scan(/>=/i))
         action { [:greater_than_or_equals_operator, text] }

      when (text = @ss.scan(/>/i))
         action { [:greater_than_operator, text] }

      when (text = @ss.scan(/\(/i))
         action { [:left_paren, text] }

      when (text = @ss.scan(/\)/i))
         action { [:right_paren, text] }

      when (text = @ss.scan(/\*/i))
         action { [:asterisk, text] }

      when (text = @ss.scan(/\//i))
         action { [:solidus, text] }

      when (text = @ss.scan(/\+/i))
         action { [:plus_sign, text] }

      when (text = @ss.scan(/\-/i))
         action { [:minus_sign, text] }

      when (text = @ss.scan(/\./i))
         action { [:period, text] }

      when (text = @ss.scan(/,/i))
         action { [:comma, text] }

      when (text = @ss.scan(/`\w+`/i))
         action { [:identifier, text[1..-2]] }

      when (text = @ss.scan(/\w+/i))
         action { [:identifier, text] }

      when (text = @ss.scan(/----/i))
        ;

      when (text = @ss.scan(/require/i))
        ;

      else
        text = @ss.string[@ss.pos .. -1]
        raise  ScanError, "can not match: '" + text + "'"
      end  # if

    when :STRS
      case
      when (text = @ss.scan(/\'/i))
         action { @state = nil;    [:quote, text] }

      when (text = @ss.scan(/.*(?=\')/i))
         action {                  [:character_string_literal, text.gsub("''", "'")] }

      else
        text = @ss.string[@ss.pos .. -1]
        raise  ScanError, "can not match: '" + text + "'"
      end  # if

    when :STRD
      case
      when (text = @ss.scan(/\"/i))
         action { @state = nil;    [:quote, text] }

      when (text = @ss.scan(/.*(?=\")/i))
         action {                  [:character_string_literal, text.gsub('""', '"')] }

      else
        text = @ss.string[@ss.pos .. -1]
        raise  ScanError, "can not match: '" + text + "'"
      end  # if

    else
      raise  ScanError, "undefined state: '" + state.to_s + "'"
    end  # case state
    token
  end  # def _next_token

end # class
