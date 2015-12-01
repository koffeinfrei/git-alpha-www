require 'fileutils'

class GitTask < Volt::Task
  def fame(repository)
    repository_name = repository.split('/').last.split('.').first
    tmp_dir = File.expand_path('tmp/repositories')
    repository_dir = "#{tmp_dir}/#{repository_name}"

    FileUtils.mkdir_p(tmp_dir)
    system 'git', 'clone', repository, repository_dir

    `bin/git-claim-sh/git-claim.sh -m #{repository_dir}`
  end
end
