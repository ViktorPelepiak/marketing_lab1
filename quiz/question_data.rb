require 'yaml'
include 'Question'

class QuestionData
    attr_accessor :colection, :yaml_dir, :in_ext

    def initialize()
        @yaml_dir = "./yml"
        @in_ext = ".yml"
    end


    #метод, який на вхід приймає блок та виконує його над кожним файлом заданого каталогу (Dir.glob - повертає імена файлів при заданні шляху до директорії та маски файлів);
    def each_file
        col = Array.new
        files = Dir[yaml_dir+"/**/*"+in_ext]
        for file in files do
            col.push (yield(file))
        end
        puts col
    end

    #завантаження інформації про тести та формування колекції запитань при допомозі методів each_file, in_thread та load_from(filename).
    def load_data 
        each_file do |file|
            load_from(File.expand_path file)
        end
    end

    #зчитування інформації з yaml файлу, перемішування відповідей, формування об'єктів типу Question та добавлення їх до колекції. 
    def load_from(filename)
        puts ("working with " + filename)
        
        questions = Array.new
        for quest in YAML.load(File.read filename) do
            q = Question.new(quest["question"], quest["answers"])
            puts q
            questions.push q
        end
    end
end

n=5
obj = QuestionData.new
#puts obj.yaml_dir
#obj.load_data


#obj.each_file() { puts "hello" }
obj.load_data