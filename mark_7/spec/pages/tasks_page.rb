require_relative 'sections'

class FormAddTask < SitePrism::Section
  element :input_name, 'input[name=title]'
  element :input_due_date, 'input[name=dueDate]'
  element :input_tags, 'div[class*=tagsinput] input'
  element :save_button, 'button[id*=submit]'

  def insert_tags(tags)
    tags.each do |t|
      input_tags.set t
      input_tags.send_keys :tab
    end
  end

  def save(task)
    input_name.set task[:name]
    input_due_date.set task[:due_date]
    insert_tags task[:tags]
    save_button.click
  end
end

class TasksPage < SitePrism::Page
  section :top_menu, TopMenu, '#navbar'
  section :toast, Toast, '#toast-container'
  section :form, FormAddTask, '#add-task'

  element :page_title, '.header-title h3'
  element :insert_button, '#insert-button'
  element :input_search, 'input[name=search]'
  element :search_button, '#search-button'

  element :tasks_view, '#tasks-view'
  element :list, 'table[id=tasks] tbody'

  elements :trs, 'table[id=tasks] tbody tr'

  def search(target)
    input_search.set target
    search_button.click
  end
end
