class Chef2Wiki

# This requires markdown extension for mediawiki.

def generate_docs
  if config["cookbooks"]["repo_paths"].any?
    puts "[Chef2Wiki]\tCreating documentation..."
    @cookbooks = []

    config["cookbooks"]["repo_paths"].each do |repo_path|
      doc_files = File.join(repo_path, "**", "README.md")

      Dir.glob(File.expand_path(doc_files)).sort.each do |file|
        cookbook = file.gsub("#{File.expand_path(repo_path)}/", "").gsub("/README.md", "")
        if cookbook != "README.md"
          @cookbooks += [cookbook]
          @content = File.read(file)
          add_page(cookbook, templates["documentation"].result(binding))
        end
      end
    end

    add_page("Cookbooks_documentation", templates["documentation_list"].result(binding))
  end
end

end
