class User::AddressesController < User::BaseController
  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      flash[:notice] = 'Address has been updated!'
      redirect_to profile_path
    else
      flash.now[:error] = @address.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    address = Address.find(params[:id])
    address.delete
    redirect_to '/profile'
  end

  private
  def address_params
    params.require(:address).permit(:address, :city, :state, :zip)
  end

end
