require '../lib/rc4.rb'
require 'iconv'

converter = Iconv.new('UTF-8','KOI8R')

Shoes.app :width => 200, :height => 200,:title => "Rc4" do
  stack do
    para "Key:"
    key = edit_line
    para "Plaintext:"
    plaintext = edit_line
    para "Encrypted text:"
    encrypted_text = edit_line
    flow do
      button "File Crypt" do
        if key.text != ''
          file_path = ask_open_file.to_s
          File.open(file_path,'r') do |source_file| 
            File.open(/([^\/]+)$/.match(file_path)[0]+".enc","w") do |encrypted_file|
              encrypted_file.puts Rc4.new(key.text).crypt(source_file.read) 
            end
          end
        else
          alert("enter key")
        end 
      end
      button "Text Crypt" do
        if (key.text != '')&&(plaintext != '')
          encrypted_text.text = converter.iconv(Rc4.new(key.text).crypt(plaintext.text))
        else
          alert("enter something")
        end
      end
    end
  end
end
