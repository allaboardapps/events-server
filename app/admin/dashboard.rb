ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Welcome to #{Time.now.strftime('%a, %b %e, %Y')}" do
          ul do
            li "link"
            li "link"
            li "link"
            li "link"
          end
        end
      end

      column do
        panel "Other Stuff" do
          ul do
            li "link"
            li "link"
            li "link"
            li "link"
            li "link"
          end
        end
      end
    end

    if Rails.env.development?
      panel "Development" do
        ul do
          li link_to "Database Viewer", "/rails/db"
          li link_to "Sidekiq", "/sidekiq"
          # li link_to "Test Form Submission Email", staff_view_form_submission_mailer_path
        end
      end
    end
  end
end
