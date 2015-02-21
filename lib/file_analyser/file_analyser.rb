module FileAnalyzer

  def suburbs_from(filename)
    suburbs = []
    file = manage_file(filename)

    if file
      suburbs = read_suburbs(file)
      file.close
    end

    suburbs
  end

  private

  def manage_file(filename)
    File.open(filename, 'r') rescue e raise(CustomError.new('File Not Found'))
  end

  def read_suburbs(file)
    nodes_array = []
    if file
      while (line = file.gets)
        nodes_array += line.split(',').map { |value| value.strip }.reject { |value| value.empty? }
      end
    end
    nodes_array
  end

end