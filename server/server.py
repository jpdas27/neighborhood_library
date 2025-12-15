import asyncio
import grpc
from grpc import aio

from proto import library_pb2, library_pb2_grpc


class LibraryService(library_pb2_grpc.LibraryServiceServicer):
    """
    Async gRPC service.
    DB is NOT used yet — we return mock data.
    """

    async def CreateBook(self, request, context):
        book = request.book

        # Fake ID assignment (DB will do this later)
        response_book = library_pb2.Book(
            id=1,
            title=book.title,
            author=book.author,
            isbn=book.isbn,
            published_year=book.published_year,
        )

        return library_pb2.CreateBookResponse(book=response_book)


async def serve():
    server = aio.server()

    library_pb2_grpc.add_LibraryServiceServicer_to_server(
        LibraryService(), server
    )

    server.add_insecure_port("[::]:50051")

    print("gRPC server running on port 50051")
    await server.start()
    await server.wait_for_termination()


if __name__ == "__main__":
    asyncio.run(serve())
