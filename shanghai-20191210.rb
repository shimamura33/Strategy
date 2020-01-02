# -*- coding: UTF-8 -*-
require 'rubygems'
require 'hpricot'
require 'open-uri'
################################本程序实现财务指定股票上市以来全部财务报表的下载
x = 1

#获取股票列表文件stocklist.txt的总行数
def wc(filename)
  $nline = $nword = $nchar = 0 #$符号表示全局变量，普通变量不在def外起作用
  File.open(filename) do |io|
    io.each_line do |line|
      words = line.split(/\s+/).reject{|w| w.empty? }
      #本例中使用了split方法分割单词，当行首有空白字符时，split方法的执行结果中会产生空白字符串，因此我们
      #会删除该空白字符串。
      $nline += 1
      $nword += words.length
      $nchar += line.length
    end
  end
  #puts "文件的行数为:#{$nline}\n文件的单词数为:#{$nword}\n文件的字符数为:#{$nchar}"
  puts "股票池股票数:#{$nword}\n"

end
wc("/Users/phoebeliu/stock15.txt")
#puts  $nword

#循环开始

while x <=  $nword - 1

#puts "轮询中:"

stock_lines = File.readlines("/Users/phoebeliu/stock15.txt");  


s_code = stock_lines[x]
scode = s_code.chomp  # chomp用来删除文本里带过来的换行符


puts "====================="
puts "正在下载#{scode}的资产负债表"

#确定csv文件命名规则
file1_path = "\\Users\\phoebeliu\\stock\\zcfzb\\"
file1_name = scode + "zcfzb.csv"
file1_name_path = file1_path + file1_name

#将网易财经接口的数据保存为csv文件
File.open(file1_name_path, 'wb') {|f| f.write(open('http://quotes.money.163.com/service/zcfzb_' + "#{scode}"+'.html') {|f1| f1.read})}

#防止接口调用过频被踢，暂停3秒
sleep(3)

puts "资产负债表下载完毕"

puts "====================="
puts "正在下载#{scode}的利润表"

#确定csv文件命名规则
file2_path = "\\Users\\phoebeliu\\stock\\lrb\\"
file2_name = scode + "lrb.csv"
file2_name_path = file2_path + file2_name

#将网易财经接口的数据保存为csv文件
File.open(file2_name_path, 'wb') {|f| f.write(open('http://quotes.money.163.com/service/lrb_' + "#{scode}"+'.html') {|f1| f1.read})}

#防止接口调用过频被踢，暂停3秒
sleep(3)

puts "利润表下载完毕"

puts "====================="
puts "正在下载#{scode}的现金流量表"

#确定csv文件命名规则
file3_path = "\\Users\\phoebeliu\\stock\\xjllb\\"
file3_name = scode + "xjllb.csv"
file3_name_path = file3_path + file3_name

#将网易财经接口的数据保存为csv文件
File.open(file3_name_path, 'wb') {|f| f.write(open('http://quotes.money.163.com/service/xjllb_' + "#{scode}"+'.html') {|f1| f1.read})}

#防止接口调用过频被踢，暂停3秒
sleep(3)


puts "现金流量表下载完毕"

puts "====================="
puts "正在下载#{scode}的主要财务指标表"

#确定csv文件命名规则
file4_path = "\\Users\\phoebeliu\\stock\\zycwzb\\"
file4_name = scode + "zycwzb.csv"
file4_name_path = file4_path + file4_name

#将网易财经接口的数据保存为csv文件
File.open(file4_name_path, 'wb') {|f| f.write(open('http://quotes.money.163.com/service/zycwzb_' + "#{scode}"+'.html') {|f1| f1.read})}

#防止接口调用过频被踢，暂停3秒
sleep(3)

puts "主要财务指标表下载完毕"
x = x + 1
end