require 'yaml'
require_relative 'Students_list'

class Students_list_YAML < Students_list
    def read_from_file(file_path)
        raise StandardError.new("Ошибка: Файл не существует") unless File.file?(file_path)
        
        data_hash = YAML.load_file(file_path)
        res = []
        data_hash.each_with_index do |el, id|
            el.transform_keys!(&:to_sym)
            el[:id] = id
            res << Student.new(**el)
        end

        @list = res
    end

    def write_to_file(file_path)
        res = []
        @list.each do |el|
            el_hash = {}
            el.instance_variables.each do |attr_name|
                el_hash[attr_name.to_s.gsub("@","")] = el.instance_variable_get(attr_name)
            end
            res << el_hash
        end

        File.write(file_path, res.to_yaml)
    end
end