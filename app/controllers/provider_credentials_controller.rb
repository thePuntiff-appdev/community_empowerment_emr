class ProviderCredentialsController < ApplicationController
  before_action :current_provider_must_be_provider_credential_provider, :only => [:edit_form, :update_row, :destroy_row]

  def current_provider_must_be_provider_credential_provider
    provider_credential = ProviderCredential.find(params["id_to_display"] || params["prefill_with_id"] || params["id_to_modify"] || params["id_to_remove"])

    unless current_provider == provider_credential.provider
      redirect_to :back, :alert => "You are not authorized for that."
    end
  end

  def index
    @q = ProviderCredential.ransack(params[:q])
    @provider_credentials = @q.result(:distinct => true).includes(:provider, :credential).page(params[:page]).per(10)

    render("provider_credential_templates/index.html.erb")
  end

  def show
    @provider_credential = ProviderCredential.find(params.fetch("id_to_display"))

    render("provider_credential_templates/show.html.erb")
  end

  def new_form
    @provider_credential = ProviderCredential.new

    render("provider_credential_templates/new_form.html.erb")
  end

  def create_row
    @provider_credential = ProviderCredential.new

    @provider_credential.provider_id = params.fetch("provider_id")
    @provider_credential.credential_id = params.fetch("credential_id")

    if @provider_credential.valid?
      @provider_credential.save

      redirect_back(:fallback_location => "/provider_credentials", :notice => "Provider credential created successfully.")
    else
      render("provider_credential_templates/new_form_with_errors.html.erb")
    end
  end

  def create_row_from_credential
    @provider_credential = ProviderCredential.new

    @provider_credential.provider_id = params.fetch("provider_id")
    @provider_credential.credential_id = params.fetch("credential_id")

    if @provider_credential.valid?
      @provider_credential.save

      redirect_to("/credentials/#{@provider_credential.credential_id}", notice: "ProviderCredential created successfully.")
    else
      render("provider_credential_templates/new_form_with_errors.html.erb")
    end
  end

  def edit_form
    @provider_credential = ProviderCredential.find(params.fetch("prefill_with_id"))

    render("provider_credential_templates/edit_form.html.erb")
  end

  def update_row
    @provider_credential = ProviderCredential.find(params.fetch("id_to_modify"))

    
    @provider_credential.credential_id = params.fetch("credential_id")

    if @provider_credential.valid?
      @provider_credential.save

      redirect_to("/provider_credentials/#{@provider_credential.id}", :notice => "Provider credential updated successfully.")
    else
      render("provider_credential_templates/edit_form_with_errors.html.erb")
    end
  end

  def destroy_row_from_provider
    @provider_credential = ProviderCredential.find(params.fetch("id_to_remove"))

    @provider_credential.destroy

    redirect_to("/providers/#{@provider_credential.provider_id}", notice: "ProviderCredential deleted successfully.")
  end

  def destroy_row_from_credential
    @provider_credential = ProviderCredential.find(params.fetch("id_to_remove"))

    @provider_credential.destroy

    redirect_to("/credentials/#{@provider_credential.credential_id}", notice: "ProviderCredential deleted successfully.")
  end

  def destroy_row
    @provider_credential = ProviderCredential.find(params.fetch("id_to_remove"))

    @provider_credential.destroy

    redirect_to("/provider_credentials", :notice => "Provider credential deleted successfully.")
  end
end
