# frozen_string_literal: true
class Admin::MembersController < ApplicationController
  before_action :set_admin_member, only: [:show, :edit, :update, :destroy]

  # GET /admin/members
  def index
    @admin_members = current_user.church.members
  end

  # GET /admin/members/1
  def show; end

  # GET /admin/members/new
  def new
    @admin_member = current_user.church.members.new
  end

  # GET /admin/members/1/edit
  def edit; end

  # POST /admin/members
  def create
    @admin_member = current_user.church.members.new(admin_member_params)
    @admin_member.password = SecureRandom.hex
    if @admin_member.save
      redirect_to @admin_member, notice: 'Member was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /admin/members/1
  def update
    if @admin_member.update(admin_member_params)
      redirect_to @admin_member, notice: 'Member was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /admin/members/1
  def destroy
    @admin_member.destroy
    redirect_to admin_members_url, notice: 'Member was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_member
    @admin_member = Admin::Member.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def admin_member_params
    params.require(:admin_member).permit(:fname, :lname, :email, :profile_picture)
  end
end
