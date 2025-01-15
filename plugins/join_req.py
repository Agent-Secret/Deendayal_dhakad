from pyrogram import Client, filters, enums
from pyrogram.types import ChatJoinRequest
from database.users_chats_db import db
from info import ADMINS, AUTH_CHANNEL

@Client.on_chat_join_request(filters.chat(AUTH_CHANNEL))
async def join_reqs(client, message: ChatJoinRequest):
    """
    Handle chat join requests from users trying to join the authentication channel.
    Ensure that the request is not already in the database before adding it.
    """
    user_id = message.from_user.id
    channel_id = message.chat.id

    try:
        if not await db.find_join_req(user_id, channel_id):
            await db.add_join_req(user_id, channel_id)
            await message.approve()  # Approve the request if it's new
            print(f"✅ Join request approved for user {user_id} in channel {channel_id}")
        else:
            await message.reject()  # Reject the request if it already exists
            print(f"⚠️ Join request already exists for user {user_id} in channel {channel_id}")
    except Exception as e:       
      print(f"❌ Error handling join request for user {user_id}: {e}")

@Client.on_message(filters.command("delreq") & filters.private & filters.user(ADMINS))
async def del_requests(client, message):
    """
    Delete all join requests from the database, triggered by an admin command.
    """
    try:
        await db.del_join_req()  # Delete all recorded join requests
        await message.reply(
            "<b>⚙️ Successfully deleted all pending join requests from the database.</b>",
            parse_mode=enums.ParseMode.HTML
        )
        print("✅ All join requests have been successfully deleted.")
    except Exception as e:
        await message.reply(
            "<b>⚠️ Failed to delete join requests. Please check logs for more details.</b>",
            parse_mode=enums.ParseMode.HTML
        )
        print(f"❌ Error deleting join requests: {e}")

