$omnipresent #=> nil
class Diety
  $omnipresent = :yes
  def preternatural?
    $omnipresent == :yes
  end
end
$omnipresent #=> :yes
Diety.new.preternatural? #=> true
