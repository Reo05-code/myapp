# frozen_string_literal: true

module ApplicationHelper
  # full_titleメソッドを定義
  def full_title(page_title = '')
    base_title = 'クックログ'
    if page_title.blank?
      base_title # トップページはタイトル「クックログ」
    else
      "#{page_title} - #{base_title}" # トップ以外のページはタイトル「利用規約 - クックログ」（例）
    end
  end
end
