class WeeklyRevenueSerializer
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
end
