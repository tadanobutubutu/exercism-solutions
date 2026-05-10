class ParallelLetterFrequency
  def self.count(texts)
    return {} if texts.empty?

    # プロセス数。
    num_procs = 4
    groups = texts.each_slice((texts.size.to_f / num_procs).ceil).to_a

    readers = []
    groups.each do |group|
      reader, writer = IO.pipe
      pid = fork do
        reader.close
        tally = Hash.new(0)
        group.each do |text|
          # 文字（UnicodeのLetter属性）のみを抽出し、小文字化してカウント
          text.downcase.scan(/\p{L}/).each do |char|
            tally[char] += 1
          end
        end
        Marshal.dump(tally, writer)
        writer.close
        exit!(0)
      end
      writer.close
      readers << reader
    end

    final_tally = Hash.new(0)
    readers.each do |reader|
      begin
        tally = Marshal.load(reader)
        tally.each { |char, count| final_tally[char] += count }
      rescue EOFError
        # 子プロセスが何も書かずに終了した場合
      end
      reader.close
    end
    
    Process.waitall
    final_tally
  end
end
