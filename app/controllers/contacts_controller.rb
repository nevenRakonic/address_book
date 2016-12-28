class ContactsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_contact, only: [:edit, :show, :destroy]
  def index
    @contacts = current_user.contacts
  end

  def show
  end

  def edit
  end

  def new
    @contact = Contact.new
    @contact.contact_attributes.build
  end

  def create
    @contact = Contact.new(contact_params)
    @contact.user = current_user
    if @contact.save
      flash[:success] = "Contact succesfully created"
      redirect_to contacts_path
    else
      @contact.contact_attributes.build unless @contact.contact_attributes.present?
      render :new
    end
  end

  def destroy
    @contact.destroy
    redirect_to contacts_path
  end

  private
    def contact_params
      params.require(:contact).permit(:first_name, :last_name, :address,
      :fixed_phone, :mobile_phone, :image,
      contact_attributes_attributes: [:id, :name, :content, :_destroy])
    end

    def get_contact
      @contact = current_user.contacts.find(params[:id])
    end
end
