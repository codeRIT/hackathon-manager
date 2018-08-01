<h2 class="center">
  Thanks for Applying!
</h2>

Hey <%= @questionnaire.first_name %>,

We've received your application to <%= Rails.configuration.hackathon['name'] %>!

If needed, you can edit your information by clicking the button below.

<%= link_to questionnaires_url, class: 'button' do %>
  My Profile
<% end %>
