class Admin::IntroductionsController < Admin::BaseController
  before_filter :load_introduction, only: [:general, :update_general]
  before_filter :load_rules, only: [:rules, :update_rules]

  def general
  end

  def rules
  end

  def update_general
    if @introduction.update introduction_params
      redirect_to general_admin_introduction_path, notice: "General introduction was updated successfully"
    else
      redirect_to general_admin_introduction_path, notice: "General introduction was not updated successfully"
    end
  end

  def update_rules
    if @rules.update rules_params
      redirect_to rules_admin_introduction_path, notice: "Rules was updated successfully"
    else
      redirect_to rules_admin_introduction_path, notice: "Rules was not updated successfully"
    end
  end

  private
  def load_introduction
    @introduction = Article::Introduction.last
    @introduction = Article::Introduction.new unless @introduction
  end

  def introduction_params
    params.require(:article_introduction).permit(:title, :content)
  end

  def load_rules
    @rules = Article::Rules.last
    @rules = Article::Rules.new unless @rules
  end

  def rules_params
    params.require(:article_rules).permit(:title, :content)
  end
end
