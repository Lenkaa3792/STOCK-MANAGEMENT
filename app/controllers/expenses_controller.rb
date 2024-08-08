class ExpensesController < ApplicationController
    before_action :set_expense, only: %i[show update destroy]

    # GET /expenses
    def index
      @expenses = Expense.all
      render json: @expenses
    end

    # GET /expenses/:id
    def show
      render json: @expense
    end

    # POST /expenses
    def create
      @expense = Expense.new(expense_params)
      if @expense.save
        render json: @expense, status: :created, location: @expense
      else
        render json: @expense.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /expenses/:id
    def update
      if @expense.update(expense_params)
        render json: @expense
      else
        render json: @expense.errors, status: :unprocessable_entity
      end
    end

    # DELETE /expenses/:id
    def destroy
      @expense.destroy
      head :no_content
    end

    private

    def set_expense
      @expense = Expense.find(params[:id])
    end

    def expense_params
      params.require(:expense).permit(:amount, :description, :expense_date, :category)
    end
  end
