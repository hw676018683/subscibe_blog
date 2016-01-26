every 1.day, at: '1:30 am' do
  rake 'blog:get_articles', output: { error: Settings.whenever.log.error, :standard => Settings.whenever.log.crons }
end