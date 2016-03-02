require 'fileutils'

class GitTask < Volt::Task
  def fame(repository)
    repository_name = repository.split('/').last.split('.').first
    tmp_dir = File.expand_path('tmp/repositories')
    repository_dir = "#{tmp_dir}/#{repository_name}"

    FileUtils.mkdir_p(tmp_dir)
    system 'git', 'clone', repository, repository_dir

    result = `bin/git-alpha/git-alpha -m #{repository_dir}`
    parse_result(result)
  end

  def parse_result(result)
    result
      .lines
      .map(&:strip)
      .map { |line| line.split("\t") }
      .map do |entry|
        {
          author: entry[0],
          lines: entry[1],
          total_lines: entry[2],
          percent: entry[3]
        }
      end
  end
end
