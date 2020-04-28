class ContactsController < ApplicationController
  
  def new
    @contact = Contact.new
  end
  
  
  def create
    @contact = Contact.new(
      name: params[:name], 
      email: params[:email],
      category: params[:category],
      content: params[:content]
      )
    if @contact.save
      flash[:notice] = "送信しました"
      redirect_to("/")
    else
      render("contacts/new")
    end
  end
    
end
