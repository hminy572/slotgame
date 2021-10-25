defmodule SlotWeb.SlotLive do
  use SlotWeb, :live_view
  import LivePixel.{Base, Button, LeftCol, CenterCol, RightCol}
  require Logger

  @normal_bonus 20
  @seven_bonus 40

  @impl true
  def mount(_, _, socket) do
    il = :rand.uniform(16)
    ic = :rand.uniform(16)
    ir = :rand.uniform(16)

    Process.send_after(self(), :num, 50)
    Process.send_after(self(), :skull_attack, 1300)

    {:ok, assign(socket, %{
        num: 0,
        # init
        init_left_num: il,
        init_center_num: ic,
        init_right_num: ir,
        # col num
        left_num: 1,
        center_num: 1,
        right_num: 1,
        # col proc
        left_proc: true,
        center_proc: true,
        right_proc: true,
        # button
        left_button: false,
        center_button: false,
        right_button: false,

        skull_image: "/images/skull/skull_appear_once_anim.webp",
        my_health: 100,
        enemy_health: 100
        })}
  end

  # *** handle event
  # ***********************************************************************

  @impl true
  def handle_event("left_button", _, socket) do
    Logger.info("left_button")
    Process.send_after(self(), :left_button_clicked, 150)
    {:noreply, assign(socket, %{left_button: true, left_proc: false })}
  end

  def handle_event("center_button", _, socket) do
    Logger.info("center_button")
    Process.send_after(self(), :center_button_clicked, 150)
    {:noreply, assign(socket, %{center_button: true, center_proc: false})}
  end

  def handle_event("right_button", _, socket) do
    Logger.info("right_button")
    Process.send_after(self(), :right_button_clicked, 150)
    {:noreply, assign(socket, %{right_button: true, right_proc: false})}
  end

  def handle_event("restart", _, socket) do
    Logger.info("restart")
    Process.send_after(self(), :num, 50)
    {:noreply, assign(socket, %{ left_proc: true, center_proc: true, right_proc: true })}
  end

  # *** handle info
  # ***********************************************************************
  @impl true
  def handle_info(:num, socket) do
    num = socket.assigns.num + 1

    left_num =
      if(socket.assigns.left_proc) do
        rem(socket.assigns.init_left_num + num, 16) + 1
      else
        # num has to be odd number
        if (rem(socket.assigns.left_num, 2) == 0) do
          socket.assigns.left_num - 1
        else
          socket.assigns.left_num
        end
      end

    center_num =
      if(socket.assigns.center_proc) do
        rem(socket.assigns.init_center_num + num, 16) + 1
      else
        if (rem(socket.assigns.center_num, 2) == 0) do
          socket.assigns.center_num - 1
        else
          socket.assigns.center_num
        end
      end

    right_num =
      if(socket.assigns.right_proc) do
        rem(socket.assigns.init_right_num + num, 16) + 1
      else
        if (rem(socket.assigns.right_num, 2) == 0) do
          socket.assigns.right_num - 1
        else
          socket.assigns.right_num
        end
      end

    if socket.assigns.left_proc == false && socket.assigns.center_proc == false && socket.assigns.right_proc == false do
      {:noreply,
        left_items(left_num) ++ center_items(center_num) ++ right_items(right_num)
        |> check_bonus(socket)
        |> assign(%{
          num: num,
          left_num: left_num,
          center_num: center_num,
          right_num: right_num,
          })}
    else
      Process.send_after(self(), :num, 50)
      {:noreply, assign(socket, %{
        num: num,
        left_num: left_num,
        center_num: center_num,
        right_num: right_num,
        })}
    end
  end

  def handle_info(:skull_attack, socket) do
    {:noreply, assign(socket, %{ skull_image: "/images/skull/skull_attack_anim.webp" })}
  end

  def handle_info(:skull_damage, socket) do
    {:noreply, assign(socket, %{ skull_image: "/images/skull/skull_attack_anim.webp" })}
  end

  def handle_info(:left_button_clicked, socket) do
    {:noreply, assign(socket, %{ left_button: false, left_proc: false })}
  end

  def handle_info(:center_button_clicked, socket) do
    {:noreply, assign(socket, %{ center_button: false, center_proc: false })}
  end

  def handle_info(:right_button_clicked, socket) do
    {:noreply, assign(socket, %{ right_button: false, right_proc: false })}
  end

  # *** private function
  # ***********************************************************************

  defp left_items(left_num) do
    case left_num do
      1 -> ["f", "s", "h"]
      3 -> ["n", "f", "s"]
      5 -> ["a", "n", "f"]
      7 -> ["d", "a", "n"]
      9 -> ["t", "d", "a"]
      11 -> ["k", "t", "d"]
      13 -> ["h", "k", "t"]
      15 -> ["s", "h", "k"]
      _ -> []
    end
  end

  defp center_items(center_num) do
    case center_num do
      1 -> ["h", "t", "n"]
      3 -> ["a", "h", "t"]
      5 -> ["d", "a", "h"]
      7 -> ["s", "d", "a"]
      9 -> ["k", "s", "d"]
      11 -> ["f", "k", "s"]
      13 -> ["n", "f", "k"]
      15 -> ["t", "n", "f"]
      _ -> []
    end
  end

  defp right_items(right_num) do
    case right_num do
      1 -> ["n", "f", "a"]
      3 -> ["s", "n", "f"]
      5 -> ["t", "s", "n"]
      7 -> ["k", "t", "s"]
      9 -> ["h", "k", "t"]
      11 -> ["d", "h", "k"]
      13 -> ["a", "d", "h"]
      15 -> ["f", "a", "d"]
       _-> []
    end
  end

  defp check_bonus(items, socket) do
    cond do
      # seven bonus
      Enum.at(items, 0) == Enum.at(items, 3) && Enum.at(items, 3) == Enum.at(items, 6) && Enum.at(items, 0) == "s" ->
        Logger.info(inspect(items) <> " h1 seven")
        attack_skull(socket, @seven_bonus)
      Enum.at(items, 1) == Enum.at(items, 4) && Enum.at(items, 4) == Enum.at(items, 7) && Enum.at(items, 1) == "s" ->
        Logger.info(inspect(items) <> " h2 seven")
        attack_skull(socket, @seven_bonus)
      Enum.at(items, 2) == Enum.at(items, 5) && Enum.at(items, 5) == Enum.at(items, 8) && Enum.at(items, 2) == "s" ->
        Logger.info(inspect(items) <> " h3 seven")
        attack_skull(socket, @seven_bonus)
      Enum.at(items, 0) == Enum.at(items, 4) && Enum.at(items, 4) == Enum.at(items, 8) && Enum.at(items, 0) == "s" ->
        Logger.info(inspect(items) <> " c1 seven")
        attack_skull(socket, @seven_bonus)
      Enum.at(items, 2) == Enum.at(items, 4) && Enum.at(items, 4) == Enum.at(items, 6) && Enum.at(items, 2) == "s" ->
        Logger.info(inspect(items) <> " c2 seven")
        attack_skull(socket, @seven_bonus)

      # normal bonus
      Enum.at(items, 0) == Enum.at(items, 3) && Enum.at(items, 3) == Enum.at(items, 6) ->
        Logger.info(inspect(items) <> " h1")
        attack_skull(socket, @normal_bonus)
      Enum.at(items, 1) == Enum.at(items, 4) && Enum.at(items, 4) == Enum.at(items, 7) ->
        Logger.info(inspect(items) <> " h2")
        attack_skull(socket, @normal_bonus)
      Enum.at(items, 2) == Enum.at(items, 5) && Enum.at(items, 5) == Enum.at(items, 8) ->
        Logger.info(inspect(items) <> " h3")
        attack_skull(socket, @normal_bonus)
      Enum.at(items, 0) == Enum.at(items, 4) && Enum.at(items, 4) == Enum.at(items, 8) ->
        Logger.info(inspect(items) <> " c1")
        attack_skull(socket, @normal_bonus)
      Enum.at(items, 2) == Enum.at(items, 4) && Enum.at(items, 4) == Enum.at(items, 6) ->
        Logger.info(inspect(items) <> " c2")
        attack_skull(socket, @normal_bonus)
      true ->
        Logger.info(inspect(items) <> "nothing matched")
        socket
    end
  end

  defp attack_skull(socket, dmg) do
    socket = assign(socket, %{ enemy_health: socket.assigns.enemy_health - dmg })
    if(socket.assigns.enemy_health > 1) do
      Process.send_after(self(), :skull_damage, 1700)
      assign(socket, %{ skull_image: "/images/skull/skull_damage_once_anim.webp" })
    else
      assign(socket, %{ skull_image: "/images/skull/skull_death_once_anim.webp" })
    end
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.base />
      <div>
      <%= if (@left_num == 1) do %><.left1 /><% end %>
      <%= if (@left_num == 2) do %><.left2 /><% end %>
      <%= if (@left_num == 3) do %><.left3 /><% end %>
      <%= if (@left_num == 4) do %><.left4 /><% end %>
      <%= if (@left_num == 5) do %><.left5 /><% end %>
      <%= if (@left_num == 6) do %><.left6 /><% end %>
      <%= if (@left_num == 7) do %><.left7 /><% end %>
      <%= if (@left_num == 8) do %><.left8 /><% end %>
      <%= if (@left_num == 9) do %><.left9 /><% end %>
      <%= if (@left_num == 10) do %><.left10 /><% end %>
      <%= if (@left_num == 11) do %><.left11 /><% end %>
      <%= if (@left_num == 12) do %><.left12 /><% end %>
      <%= if (@left_num == 13) do %><.left13 /><% end %>
      <%= if (@left_num == 14) do %><.left14 /><% end %>
      <%= if (@left_num == 15) do %><.left15 /><% end %>
      <%= if (@left_num == 16) do %><.left16 /><% end %>
      </div>
      <div>
      <%= if (@center_num == 1) do %><.center1 /><% end %>
      <%= if (@center_num == 2) do %><.center2 /><% end %>
      <%= if (@center_num == 3) do %><.center3 /><% end %>
      <%= if (@center_num == 4) do %><.center4 /><% end %>
      <%= if (@center_num == 5) do %><.center5 /><% end %>
      <%= if (@center_num == 6) do %><.center6 /><% end %>
      <%= if (@center_num == 7) do %><.center7 /><% end %>
      <%= if (@center_num == 8) do %><.center8 /><% end %>
      <%= if (@center_num == 9) do %><.center9 /><% end %>
      <%= if (@center_num == 10) do %><.center10 /><% end %>
      <%= if (@center_num == 11) do %><.center11 /><% end %>
      <%= if (@center_num == 12) do %><.center12 /><% end %>
      <%= if (@center_num == 13) do %><.center13 /><% end %>
      <%= if (@center_num == 14) do %><.center14 /><% end %>
      <%= if (@center_num == 15) do %><.center15 /><% end %>
      <%= if (@center_num == 16) do %><.center16 /><% end %>
      </div>
      <div>
      <%= if (@right_num == 1) do %><.right1 /><% end %>
      <%= if (@right_num == 2) do %><.right2 /><% end %>
      <%= if (@right_num == 3) do %><.right3 /><% end %>
      <%= if (@right_num == 4) do %><.right4 /><% end %>
      <%= if (@right_num == 5) do %><.right5 /><% end %>
      <%= if (@right_num == 6) do %><.right6 /><% end %>
      <%= if (@right_num == 7) do %><.right7 /><% end %>
      <%= if (@right_num == 8) do %><.right8 /><% end %>
      <%= if (@right_num == 9) do %><.right9 /><% end %>
      <%= if (@right_num == 10) do %><.right10 /><% end %>
      <%= if (@right_num == 11) do %><.right11 /><% end %>
      <%= if (@right_num == 12) do %><.right12 /><% end %>
      <%= if (@right_num == 13) do %><.right13 /><% end %>
      <%= if (@right_num == 14) do %><.right14 /><% end %>
      <%= if (@right_num == 15) do %><.right15 /><% end %>
      <%= if (@right_num == 16) do %><.right16 /><% end %>
      </div>
      <%= if (@left_button) do %><.left_button_clicked /><% else %><.left_button /><% end%>
      <%= if (@center_button) do %><.center_button_clicked /><% else %><.center_button /><% end%>
      <%= if (@right_button) do %><.right_button_clicked /><% else %><.right_button /><% end%>

      <button phx-click="restart">restart</button>
      <div class="enemy">
        <img id="skull" phx-click="skull" src={Routes.static_path(@socket, @skull_image)} alt="skull_image" height="300" width="300">
        <div class="health-bar">
          <div class="bar" style={"width: " <> inspect(@enemy_health) <> "%; height: 10px; background: #c54;"}></div>
        </div>
      </div>
    </div>
    """
  end
end

# <div><%= @left_num %></div><div><%= @center_num %></div><div><%= @right_num %></div>
