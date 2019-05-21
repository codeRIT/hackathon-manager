class DropPaperclipAttachmentsFromQuestionnaires < ActiveRecord::Migration[5.2]
  def change
    columns = [:resume_file_name, :resume_content_type, :resume_file_size, :resume_updated_at]
    columns.each do |column|
      if column_exists?(:questionnaires, column)
        remove_column :questionnaires, column
      end
    end
  end
end
