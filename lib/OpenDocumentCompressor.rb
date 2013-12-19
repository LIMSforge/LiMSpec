module OpenDocumentCompressor
  require 'zip/zip'
  require 'find'
  private

  ODF_FILE_MIME_TYPES = {
    "odt" => ["text",                  "Text Document"],
    "odg" => ["graphics",              "Graphics document (Drawing)"],
    "odp" => ["presentation",          "Presentation Document"],
    "ods" => ["spreadsheet",           "Spreadsheet document"],
    "odc" => ["chart",                 "Chart document"],
    "odi" => ["image",                 "Image document"],
    "odf" => ["formula",               "Formula document"],
    "odm" => ["text-master",           "Global Text document"]
  }

  ODF_TEMPLATE_MIME_TYPES = {
    "ott" => ["text-template",         "Text document used as template"],
    "oth" => ["text-web",              "Text document used as template for HTML documents"],
    "otg" => ["graphics-template",     "Drawing document used as template"],
    "otp" => ["presentation-template", "Presentation document used as template"],
    "ots" => ["spreadsheet-template",  "Spreadsheet document used as template"],
    "otc" => ["chart-template",        "Chart document used as template"],
    "oti" => ["image-template",        "Image document used as template"],
    "otf" => ["formula-template",      "Formula document used as template"]
  }

  ODF_MIME_TYPES = ODF_FILE_MIME_TYPES.merge(ODF_TEMPLATE_MIME_TYPES)
  ODF_MIME_TYPE_PREFIX = "application/vnd.oasis.opendocument"

  #in order to use this method efficiently, you must remember that everything in here is based on params[:format],
  #so you should use this inside of respond_to do |format|

  #for example, if you would like to render .odp files (presentation) then you must do so like this
  #step 1:
  #   include this module in your application controller
  #
  #step 2; register the mimetype in config/initializers/mime_types.rb
  #     for example, if you wish to use format.odp, you must register the odp mimetype like so:
  #     Mime::Type.register "application/vnd.oasis.opendocument.presentation", :odp
  #     if you want, you can use the constants in this module to register all the mime-types at once.
  #     the key is the file extension, and the first value of the array is the type, it will go after application/vnd.oasis.opendocument. the loop may look something like this
  #
  #     OpenDocumentCompressor::ODF_MIME_TYPES.each do |key, value|
  #       Mime::Type.register "application/vnd.oasis.opendocument.#{value[0]}", key
  #     end
  #
  #step 3: build a respond_to block in the action you wish to have render dynamic odp content and call this method like so:
  #    respond_to do |format|
  #      format.odp {send_open_document_file}
  #    end
  #
  #step 4: create a directory in app/views/layouts that is an EXACT replica of what you get when you unzip an opendocument file.
  #   the best way to do that is to create a directory called app/views/layouts/odp and put and .odp file in there and unzip it.
  #   you can test whether or not you have it right by calling the action you wish to export from your browser. you should get a file download dialogue,
  #   and when you open the file, it should look the same as the one you used to create the layout directory.
  #
  #step 5: once you have your directory built properly, you must modify the files you wish to include dynamic content in as such
  #   first, you must add a .erb file extension. (I use erb rather than builder here, simply because i don't want to have to port all the xml already in the files to the builder syntax)
  #   second, figure out what parts of the file should be part of the layout, here's an example of my content.xml.erb file for my odp directory :
  #   <?xml version="1.0" encoding="UTF-8"?>
  #   <office:document-content office:version="1.2">
  #     <office:scripts/>
  #     <office:automatic-styles>
  #       <%= yield :automatic_styles %>
  #     </office:automatic-styles>
  #     <office:body>
  #       <office:presentation>
  #         <%= yield %>
  #       <presentation:settings presentation:mouse-visible="false"/>
  #       </office:presentation>
  #     </office:body>
  #   </office:document-content>
  #remember that yield will work in these files the same way they would in any other template you want to render.
  # step 6;
  #   now you need to create the template directories.
  #   let's say you have a resource called Foo, and you wish to have the show action of this resource render an odp.
  #   first you would need a directory named app/views/foos/odp/show
  #   inside this directory, you MAY put a template file for each layout file you have in your layout directory. for example,
  #   if you have a content.xml.erb file in your layout, you may have a content.xml.erb file in your template. if you do not, the layout will be rendered without any other content.
  #
  # please keep in mind that this code is very raw, and it will probably take some work on your part to make it work the way you want. if you have suggestions on how to improve this code, I'm all ears :)
  # -C
  # chris dot drappier at gmail dot com

  def send_open_document_file

    #create a temporary file to hold the archive.
    t = Tempfile.new("template-for-#{params[:controller]}-#{params[:action]}-#{params[:format]}-#{request.remote_ip}")

    # Give the path of the temp file to the zip outputstream, it won't try to open it as an archive.
    Zip::ZipOutputStream.open(t.path) do |zos|
      Find.find("app/views/layouts/#{params[:format]}") do |layout_path|
        basename = File.basename(layout_path)

        #ignore hidden files
        if basename[0] == ?.
          Find.prune
        else
          #this is the path that the layout file will live in once it's in the zip.
          relative_path = layout_path.gsub(/^app\/views\/layouts\/#{params[:format]}\//, '')

          unless File.directory?(layout_path)
            #start the next file in the zip.
            zos.put_next_entry(relative_path.gsub(/\.erb$/, ''))

            #if the file is not an erb file, just read it in.
            if !layout_path.match(/.*\.erb$/)
              content = IO.read(layout_path)
            else
              content = openoffice_content(layout_path, basename)
            end
            zos.print content
          end #eo unless FileTest.directory?(layout_path)
        end #eo if basename[0] == ?.
      end #eo Find.find
    end #eo Zip::ZipOutputStream.open

    # End of the block  automatically closes the file.
    # Send it using the right mime type, with a download window and some nice file name.
    send_file t.path, :type => "#{ODF_MIME_TYPE_PREFIX}.#{ODF_MIME_TYPES[params[:format]]}", :disposition => 'attachment', :filename => "#{params[:reqFileName]}.#{params[:format]}"

    # The temp file will be deleted some time...
    t.close
  end

  #you may put a template file in the location specified here. for example:
  #if you're trying to reach a resource located at http://localhost:3000/foo/1.odp
  #then this will look for a directory called app/views/foo/odp/show to get the templates for each file in the final odp.
  def openoffice_content(layout_path, basename)
    filename = basename[0..(basename.index(".")-1)]
    template_path = "app/views/#{params[:controller]}/#{params[:format]}/#{params[:action]}/#{basename}"
    layout_path = "app/views/layouts/#{params[:format]}/#{basename}"
    temp_ref_path = "#{params[:controller]}/#{params[:format]}/#{params[:action]}/#{filename}.xml"
    layout_ref_path = "layouts/#{params[:format]}/#{filename}.xml"

    #each registered mime-type needs a template directory in app/views/layouts that corresponds to the mimetype. Example:
    #the template for odp can be found in app/views/layouts/odp

    #if there's a template in the directory, render it with the layout. if there's not, just render the layout.

  if File.exists?(template_path)
      #for each file, evaluate the template code to a string
      content = render_to_string(:template => temp_ref_path, :layout => layout_ref_path)
   else
      content = render_to_string(:template => layout_ref_path)
   end
    content
  end
end