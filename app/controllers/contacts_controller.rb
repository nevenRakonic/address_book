class ContactsController < ApplicationController
  before_action :authenticate_user!
  def index
    @contacts = current_user.contacts
  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    @contact.user = current_user
    if @contact.save
      flash[:success] = "Contact succesfully created"
      redirect_to contacts_path
    else
      render :new
    end
  end

  private
    def contact_params
      params.require(:contact).permit(:first_name, :last_name, :address,
      :fixed_phone, :mobile_phone, :image)
    end
end
