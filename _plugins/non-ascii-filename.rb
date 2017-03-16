require "webrick"

module Jekyll
  module Commands
    class Serve
      class Servlet < WEBrick::HTTPServlet::FileHandler
        def prevent_directory_traversal(req, res)
            path = req.path_info.dup.force_encoding(Encoding.find("utf-8"))
            if trailing_pathsep?(req.path_info)
                expanded = File.expand_path(path + "x")
                expanded.chop!
            else
                expanded = File.expand_path(path)
            end
            expanded.force_encoding(req.path_info.encoding)
            req.path_info = expanded
        end
      end
    end
  end
end
