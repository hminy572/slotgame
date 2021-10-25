defmodule LivePixel.Button do
  use Phoenix.Component

  # *********************
  # *** button **********
  # *********************

  def left_button(assigns) do
    ~H"""
    <svg
      phx-click="left_button"
      id="left_button"
      viewBox="185 450 60 60"
      width="60"
      height="60"
      xmlns="http://www.w3.org/2000/svg"
      shape-rendering="crispEdges">
      <path fill="#DF7126" d="M200 450h10v10h-10zM210 450h10v10h-10zM220 450h10v10h-10zM190 460h10v10h-10z"/>
      <path fill="#FFF" d="M200 460h10v10h-10z"/>
      <path fill="#DF7126" d="M210 460h10v10h-10zM220 460h10v10h-10zM230 460h10v10h-10zM190 470h10v10h-10zM200 470h10v10h-10zM210 470h10v10h-10zM220 470h10v10h-10zM230 470h10v10h-10z"/>
      <path fill="#AC3232" d="M190 480h10v10h-10z"/>
      <path fill="#DF7126" d="M200 480h10v10h-10zM210 480h10v10h-10zM220 480h10v10h-10z"/>
      <path fill="#AC3232" d="M230 480h10v10h-10zM200 490h10v10h-10zM210 490h10v10h-10zM220 490h10v10h-10z"/>
    </svg>
    """
  end

  def left_button_clicked(assigns) do
    ~H"""
    <svg
      id="left_button_clicked"
      viewBox="185 450 60 60"
      width="60"
      height="60"
      xmlns="http://www.w3.org/2000/svg"
      shape-rendering="crispEdges">
      <path fill="#DF7126" d="M200 460h10v10h-10zM210 460h10v10h-10zM220 460h10v10h-10zM190 470h10v10h-10z"/>
      <path fill="#FFF" d="M200 470h10v10h-10z"/>
      <path fill="#DF7126" d="M210 470h10v10h-10zM220 470h10v10h-10zM230 470h10v10h-10zM190 480h10v10h-10zM200 480h10v10h-10zM210 480h10v10h-10zM220 480h10v10h-10zM230 480h10v10h-10zM200 490h10v10h-10zM210 490h10v10h-10zM220 490h10v10h-10z"/>
    </svg>
    """
  end

  def center_button(assigns) do
    ~H"""
    <svg
      phx-click="center_button"
      id="center_button"
      viewBox="285 450 60 60"
      width="60"
      height="60"
      xmlns="http://www.w3.org/2000/svg"
      shape-rendering="crispEdges">
      <path fill="#DF7126" d="M300 450h10v10h-10zM310 450h10v10h-10zM320 450h10v10h-10zM290 460h10v10h-10z"/>
      <path fill="#FFF" d="M300 460h10v10h-10z"/>
      <path fill="#DF7126" d="M310 460h10v10h-10zM320 460h10v10h-10zM330 460h10v10h-10zM290 470h10v10h-10zM300 470h10v10h-10zM310 470h10v10h-10zM320 470h10v10h-10zM330 470h10v10h-10z"/>
      <path fill="#AC3232" d="M290 480h10v10h-10z"/>
      <path fill="#DF7126" d="M300 480h10v10h-10zM310 480h10v10h-10zM320 480h10v10h-10z"/>
      <path fill="#AC3232" d="M330 480h10v10h-10zM300 490h10v10h-10zM310 490h10v10h-10zM320 490h10v10h-10z"/>
    </svg>
    """
  end

  def center_button_clicked(assigns) do
    ~H"""
    <svg
      id="center_button_clicked"
      viewBox="285 450 60 60"
      width="60"
      height="60"
      xmlns="http://www.w3.org/2000/svg"
      shape-rendering="crispEdges">
      <path fill="#DF7126" d="M300 460h10v10h-10zM310 460h10v10h-10zM320 460h10v10h-10zM290 470h10v10h-10z"/>
      <path fill="#FFF" d="M300 470h10v10h-10z"/>
      <path fill="#DF7126" d="M310 470h10v10h-10zM320 470h10v10h-10zM330 470h10v10h-10zM290 480h10v10h-10zM300 480h10v10h-10zM310 480h10v10h-10zM320 480h10v10h-10zM330 480h10v10h-10zM300 490h10v10h-10zM310 490h10v10h-10zM320 490h10v10h-10z"/>
    </svg>
    """
  end

  def right_button(assigns) do
    ~H"""
    <svg
      phx-click="right_button"
      id="right_button"
      viewBox="385 450 60 60"
      width="60"
      height="60"
      xmlns="http://www.w3.org/2000/svg"
      shape-rendering="crispEdges">
      <path fill="#DF7126" d="M400 450h10v10h-10zM410 450h10v10h-10zM420 450h10v10h-10zM390 460h10v10h-10z"/>
      <path fill="#FFF" d="M400 460h10v10h-10z"/>
      <path fill="#DF7126" d="M410 460h10v10h-10zM420 460h10v10h-10zM430 460h10v10h-10zM390 470h10v10h-10zM400 470h10v10h-10zM410 470h10v10h-10zM420 470h10v10h-10zM430 470h10v10h-10z"/>
      <path fill="#AC3232" d="M390 480h10v10h-10z"/>
      <path fill="#DF7126" d="M400 480h10v10h-10zM410 480h10v10h-10zM420 480h10v10h-10z"/>
      <path fill="#AC3232" d="M430 480h10v10h-10zM400 490h10v10h-10zM410 490h10v10h-10zM420 490h10v10h-10z"/>
    </svg>
    """
  end

  def right_button_clicked(assigns) do
    ~H"""
    <svg
      id="right_button_clicked"
      viewBox="385 450 60 60"
      width="60"
      height="60"
      xmlns="http://www.w3.org/2000/svg"
      shape-rendering="crispEdges">
      <path fill="#DF7126" d="M400 460h10v10h-10zM410 460h10v10h-10zM420 460h10v10h-10zM390 470h10v10h-10z"/>
      <path fill="#FFF" d="M400 470h10v10h-10z"/>
      <path fill="#DF7126" d="M410 470h10v10h-10zM420 470h10v10h-10zM430 470h10v10h-10zM390 480h10v10h-10zM400 480h10v10h-10zM410 480h10v10h-10zM420 480h10v10h-10zM430 480h10v10h-10zM400 490h10v10h-10zM410 490h10v10h-10zM420 490h10v10h-10z"/>
    </svg>
    """
  end

end
