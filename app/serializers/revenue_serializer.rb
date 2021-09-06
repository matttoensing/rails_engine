class RevenueSerializer
  # include FastJsonapi::ObjectSerializer

  def self.format_json(weekly_revenue)
    {data: weekly_revenue(weekly_revenue).flatten}
    end

    def self.weekly_revenue(weekly_revenue)
      weekly_revenue.map do |week, revenue|
        [id: nil,
        type: 'weekly_revenue',
        attributes:
        { week: week.strftime("%Y-%m-%d"),
          revenue: revenue }]
        end
      end

      def self.format_top_revenue(merchants)
        { data: top_revenue(merchants).flatten}
      end

      def self.top_revenue(merchants)
        merchants.map do |merchant|
          [id: merchant.id.to_s,
          type: 'merchant_name_revenue',
          attributes:
          { name: merchant.name,
            revenue: merchant.revenue }]
        end
      end

      def self.format_unshipped_invoices(invoices)
        { data: unshipped_invoices(invoices).flatten }
      end

      def self.unshipped_invoices(invoices)
        invoices.map do |invoice_id, revenue|
          [
            id: invoice_id.to_s,
            type: "unshipped_order",
            attributes: {
              potential_revenue: revenue
            }
          ]
        end
      end
    end
