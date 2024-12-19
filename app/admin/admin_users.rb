ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation, :role
  menu label: "Aspirents"

  index do
    selectable_column
    id_column
    column :email
    column :role
    column "Balanced Token" do |user|
       user.user_plan.balanced_token
    end
    column "Charged Token" do |user|
      user.answer.sum(:charged_token)
    end
    column "Usage Token" do |user|
      user.answer.sum(:usage_token)
    end
    actions
  end

  filter :email

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :role
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :email
      row :role
      row :created_at
      row :progress do
        content_tag(:div, id: "progress-container") do
          content_tag(:div, "", id: "progress-bar", style: "width:0%; background:green; height: 10x;")
        end
      end
    end

    div id: "progress-script" do
      script do
        raw %Q(
          function fetchProgress() {
            var progressBar = document.getElementById('progress-bar');
            $.ajax({
              url: "/fetch_data?id=#{resource.id}",
              method: "GET",
              dataType: "json",
              success: function(data) {
                 progressBar.style.width = data[0] + '%';
                 progressBar.innerText = data[0] + '%';
                 progressBar.style.color = 'white';
                  if (data[0] != 100) {
                    setTimeout(fetchProgress, 1000); // Poll every second
                  }
              },
              error: function() {
                progressBar.style.width = '100%';
                progressBar.style.color = 'white';
                progressBar.style.background = 'red';
                progressBar.innerText = 'Error fetching progress';
              }
            });
          }

          fetchProgress(); // Initialize progress update
        )
      end
    end
  end

end
