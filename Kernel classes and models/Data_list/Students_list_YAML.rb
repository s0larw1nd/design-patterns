require 'yaml'
require_relative 'File_strategy'

class Students_list_YAML < File_strategy
    def read_from_file(file_path)
        raise StandardError.new("Ошибка: Файл не существует") unless File.file?(file_path)
        
        data = YAML.load_file(file_path)
        res = []
        data.each_with_index do |el, id|
            el.transform_keys!(&:to_sym)
            el[:id] = id
            res << Student.new(**el)
        end

        res
    end

    def write_to_file(list, file_path)
        res = []
        list.each do |el|
            res << el.to_hash
        end

        File.write(file_path, res.to_yaml)
    end
end