module MessagesConcern
  extend ActiveSupport::Concern

  def order_messages(messages_list)
    messages_list.order('created_at DESC')
                 .paginate(page: 1, per_page: 20)
                 .reverse
  end
end
